Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751882AbWCBIX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbWCBIX0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 03:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751945AbWCBIX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 03:23:26 -0500
Received: from 26.mail-out.ovh.net ([213.186.42.179]:45740 "EHLO
	26.mail-out.ovh.net") by vger.kernel.org with ESMTP
	id S1751882AbWCBIX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 03:23:26 -0500
Date: Thu, 02 Mar 2006 09:23:02 +0100
To: "Pavel Machek" <pavel@suse.cz>
Subject: Re: o_sync in vfat driver
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <op.s5kzao2jj68xd1@mail.piments.com> <op.s5lq2hllj68xd1@mail.piments.com> <20060227132848.GA27601@csclub.uwaterloo.ca> <1141048228.2992.106.camel@laptopd505.fenrus.org> <1141049176.18855.4.camel@imp.csi.cam.ac.uk> <1141050437.2992.111.camel@laptopd505.fenrus.org> <1141051305.18855.21.camel@imp.csi.cam.ac.uk> <op.s5ngtbpsj68xd1@mail.piments.com> <Pine.LNX.4.61.0602271610120.5739@chaos.analogic.com> <op.s5nm6rm5j68xd1@mail.piments.com> <20060228223855.GC5831@elf.ucw.cz>
From: col-pepper@piments.com
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <op.s5r1koxmj68xd1@mail.piments.com>
In-Reply-To: <20060228223855.GC5831@elf.ucw.cz>
User-Agent: Opera M2/8.52 (Linux, build 1631)
X-Ovh-Remote: 83.177.226.6 (d83-177-226-6.cust.tele2.fr)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: fait|type 1&3|0.3|H 0.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2006 23:38:55 +0100, Pavel Machek <pavel@suse.cz> wrote:

> On Út 28-02-06 00:21:53, col-pepper@piments.com wrote:
>> On Mon, 27 Feb 2006 22:32:07 +0100, linux-os (Dick Johnson)
>> <linux-os@analogic.com> wrote:
>>
>> > Flash does not get zeroed to be written! It gets erased, which sets  
>> all
>> > the bits to '1', i.e., all bytes to 0xff.
>>
>> Thanks for the correction, but that does not change the discussion.
>>
>> > Further, the designers of
>> > flash disks are not stupid as you assume. The direct access occurs
>> > to static RAM (read/write stuff).
>>
>> I'm not assuming anything . Some hardware has been killed by this issue.
>> http://lkml.org/lkml/2005/5/13/144
>
> I have seen flash disk dead in 5 minutes, even without o-sync. Those
> devices are often crap. (I copied tar file to flash by cat foo.tar >
> /dev/sda. That was apparently enough to kill that flash. Label "Yahoo"
> should have warned me).
> 								Pavel

If I'm not mistaken, writing to the device with cat will output that file  
byte by byte. This would probably be even harder on the device than using  
a formatted device with o_sync, since it would dirty a 64k block 64k times!

It seems some of the less elaborate devices dont support this type of use.

I suspect if you had tried using dd with a suitable bs you may still own a  
crap Yahoo usb device.

Just because the linux kernel lets us use the abstract /dev devices freely  
does not mean everything you can do with a /dev is a good idea for all h/w  
that gets a device name.

I think that is the heart of the problem. Manufacturers are designing  
these devices for the windows market. They are specifically designed and  
supplied, preformatted with a fat fs, to be used in that way.

If linux distros, MacOS or anybody else wants to claim to support these  
devices the default setup should probably handle the devices in a  
_similar_ way to the native windows drivers.




