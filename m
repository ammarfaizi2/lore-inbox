Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261947AbTC0MQD>; Thu, 27 Mar 2003 07:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262103AbTC0MQD>; Thu, 27 Mar 2003 07:16:03 -0500
Received: from a089148.adsl.hansenet.de ([213.191.89.148]:63107 "EHLO
	ds666.starfleet") by vger.kernel.org with ESMTP id <S261947AbTC0MQC>;
	Thu, 27 Mar 2003 07:16:02 -0500
Message-ID: <3E82EE25.3070308@portrix.net>
Date: Thu, 27 Mar 2003 13:27:17 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
Organization: portrix.net GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030305
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Schlemmer <azarah@gentoo.org>
CC: Greg KH <greg@kroah.com>, Mark Studebaker <mds@paradyne.com>,
       KML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>,
       sensors@Stimpy.netroedge.com
Subject: Re: lm sensors sysfs file structure
References: <1048582394.4774.7.camel@workshop.saharact.lan>	 <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan>	 <3E82024A.4000809@portrix.net> <20030326202622.GJ24689@kroah.com>	 <3E82292E.536D9196@paradyne.com> <20030326225234.GA27436@kroah.com>	 <3E82D678.9000807@portrix.net> <1048762244.4773.1258.camel@workshop.saharact.lan>
In-Reply-To: <1048762244.4773.1258.camel@workshop.saharact.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schlemmer wrote:
> On Thu, 2003-03-27 at 12:46, Jan Dittmer wrote:
> 
>>Greg KH wrote:
>>
>>>True, but multi-valued files are not allowed in sysfs.  It's especially
>>>obnoxious that you have 3 value files when you read them, but only
>>>expect 2 values for writing.  The way I split up the values in the
>>>lm75.c driver shows a user exactly which values  are writable, and
>>>enforces this on the file system level.
>>
> 
> Right, can we just get this finalised soon ?  Not much fun in redoing
> something 2 times already ;)
> 

Btw., why is temperature conversion done twice? First time in kernel 
space and then with the help of sensors.conf again in user space?
Wouldn't it be much nicer to move this to the drivers? So there would be 
no need anymore to do this in userspace and one could rely on the values
found in sysfs?!

Thanks,

Jan



