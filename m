Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318948AbSHSQyd>; Mon, 19 Aug 2002 12:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318945AbSHSQyc>; Mon, 19 Aug 2002 12:54:32 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43535 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318947AbSHSQyc>; Mon, 19 Aug 2002 12:54:32 -0400
Message-ID: <3D61239A.7030405@zytor.com>
Date: Mon, 19 Aug 2002 09:58:02 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: klibc and logging
References: <3D58B14A.5080500@zytor.com> <20020819142734.B17471@flint.arm.linux.org.uk> <3D60F9A6.6020304@zytor.com> <20020819175429.C17471@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
>>I really think this is a bad idea.  The kmsg device has different 
>>properties -- for example, you're supposed to tag things with the 
>>message importance.  It really matches the syslog(3) interface better. 
>>Also, the special case makes me nervous.
> 
> Without something like this, it means that effectively the "echo" command
> wouldn't be useable, or you'd have to pipe the output of all scripts
> through some program/to /dev/kmsg.
> 
> Or we just forget logging the messages from initramfs scripts.
> 

Either we can add a "syslog" binary, or you can:

echo '<3>The dohickey is fscked' > /dev/kmsg

	-hpa

