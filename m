Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288071AbSAMUMq>; Sun, 13 Jan 2002 15:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288089AbSAMUMg>; Sun, 13 Jan 2002 15:12:36 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27409 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288071AbSAMUMW>; Sun, 13 Jan 2002 15:12:22 -0500
Message-ID: <3C41EA0D.2050205@zytor.com>
Date: Sun, 13 Jan 2002 12:11:57 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: initramfs buffer spec -- second draft
In-Reply-To: <a1oqmm$is3$1@cesium.transmeta.com> <m1ofjyqb7t.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> 
> Comments.  Endian issues are not specified, is the data little, big
> or vax endian?
> 


Not applicable.  There are no endian-specific binary structure in the 
format AT ALL.  ASCII-coded fields are always bigendian.


> What is the point of alignment?  If the data starts as 4 byte aligned,
> the 6 byte magic string guarantees the data will be only 2 byte
> aligned.  This isn't good for 32 or 64 bit architectures.


They're ASCII-coded, so it supposedly doesn't matter (yet, it's a bit 
daft, but blame the SysV people.)  The alignment makes sure the *data* 
field is 4-byte aligned.


> I do like having a c_magic that at least allows us to change things
> in the future if necessary.


It's pretty clear from a lot of the comments that a number of people 
haven't understood that the cpio encapsulation *THIS IS A CODIFICATION 
OF AN EXISTING FORMAT.*

	-hpa


