Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129790AbRAKP2T>; Thu, 11 Jan 2001 10:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131142AbRAKP17>; Thu, 11 Jan 2001 10:27:59 -0500
Received: from smtp1.mail.yahoo.com ([128.11.69.60]:45328 "HELO
	smtp1.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129790AbRAKP14>; Thu, 11 Jan 2001 10:27:56 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A5C8DB2.48A4A48@yahoo.com>
Date: Wed, 10 Jan 2001 11:28:34 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.4.0 i486)
MIME-Version: 1.0
To: rob@sysgo.de
CC: Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org
Subject: Re: Anybody got 2.4.0 running on a 386 ?
In-Reply-To: <01010922090000.02630@rob> <01010923324500.02850@rob> <3A5B98AB.9B6FABC6@didntduck.org> <01011000082300.03050@rob>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Kaiser wrote:
> 
> The one I'm currently using is an old Olivetti 386SX with 5 MB, I also
> tried two more boards, one 386SX, one 386DX, both with 8MB. All showed 
> the same behavior.

I tested 2.4.0 on probably the exact same box - an Olivetti M300-05 
386sx with 5MB and it came up ok, except that memory detection is off
by a MB. (to be fixed in 2.4.1 or boot with mem= argument in 2.4.0)

What might be important here is your gcc & binutils (as/gas) version,
combined with a miscompile in something like __verify_write that
doesn't get used on anything but 386 (and hence went undetected).

Only thing strange on my box is that the kernel is compiled with 
gcc-2.7.2 which is officially unsupported but can be managed if you 
know what the gcc bugs are.  

Paul.



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
