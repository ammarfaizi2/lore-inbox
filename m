Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318954AbSHSRYI>; Mon, 19 Aug 2002 13:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318959AbSHSRYI>; Mon, 19 Aug 2002 13:24:08 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8978 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318954AbSHSRYH>; Mon, 19 Aug 2002 13:24:07 -0400
Message-ID: <3D612A9F.3080807@zytor.com>
Date: Mon, 19 Aug 2002 10:27:59 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: klibc and logging
References: <3D58B14A.5080500@zytor.com> <20020819142734.B17471@flint.arm.linux.org.uk> <3D60F9A6.6020304@zytor.com> <20020819175429.C17471@flint.arm.linux.org.uk> <3D61239A.7030405@zytor.com> <20020819182542.D17471@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Mon, Aug 19, 2002 at 09:58:02AM -0700, H. Peter Anvin wrote:
> 
>>Either we can add a "syslog" binary, or you can:
>>
>>echo '<3>The dohickey is fscked' > /dev/kmsg
> 
> Ok, that's fine for the echo-from-scripts problem.  Now what if I bring
> in something like stderr of gzip?  I suppose we need to modify all
> programs like gzip, etc to use syslog (maybe making perror() log to
> syslog)?
> 

We need to think carefully about it.  perror() and the likes are meant
to be taken in the context of having just executed a command, whereas a
syslog message needs to make sense on its own.  That's part of why I
think making it stderr default is a bad idea.

	-hpa

