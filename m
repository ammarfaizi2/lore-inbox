Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRAIB0X>; Mon, 8 Jan 2001 20:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129632AbRAIB0N>; Mon, 8 Jan 2001 20:26:13 -0500
Received: from [139.102.15.43] ([139.102.15.43]:59566 "EHLO
	online.indstate.edu") by vger.kernel.org with ESMTP
	id <S129267AbRAIB0B>; Mon, 8 Jan 2001 20:26:01 -0500
From: "Rich Baum" <baumr1@coral.indstate.edu>
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>, linux-kernel@vger.kernel.org
Date: Mon, 8 Jan 2001 20:23:56 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] More compile warning fixes for 2.4.0
Reply-to: richbaum@acm.org
CC: linux-kernel@vger.kernel.org
Message-ID: <3A5A21DC.11296.5CFA3C@localhost>
In-Reply-To: <20010108205001.S3472@arthur.ubicom.tudelft.nl>
In-Reply-To: <3A5790E3.18256.963C79@localhost>; from baumr1@coral.indstate.edu on Sat, Jan 06, 2001 at 09:40:51PM -0500
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Jan 2001, at 20:50, Erik Mouw wrote:

> On Sat, Jan 06, 2001 at 09:40:51PM -0500, Rich Baum wrote:
> > Here's a patch that fixes more of the compile warnings with gcc 
> > 2.97.
> 
> > -    case FORE200E_STATE_BLANK:
> > +    case FORE200E_STATE_BLANK:;
> 
> Is this really a kernel bug? This is common idiom in C, so gcc
> shouldn't warn about it. If it does, it is a bug in gcc IMHO.
> 
> 
> Erik
> (compiling a GCC CVS snapshot to see if it really breaks)
> 
> -- 
> J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
> of Electrical Engineering, Faculty of Information Technology and Systems,
> Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
> Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
> WWW: http://www-ict.its.tudelft.nl/~erik/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

It still compiles and works just as well as it does without the patch. 
 Without the patch it says: 
warning: deprecated use of label at end of compound statement

My patches are basically telling the compiler to be quiet.  If you 
use egcs it won't give these warnings even if the code hasn't been 
patched.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
