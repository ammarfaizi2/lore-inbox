Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129703AbRAXSu3>; Wed, 24 Jan 2001 13:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131368AbRAXSuT>; Wed, 24 Jan 2001 13:50:19 -0500
Received: from smtp3.mail.yahoo.com ([128.11.68.135]:62218 "HELO
	smtp1b.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129703AbRAXSuM>; Wed, 24 Jan 2001 13:50:12 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A6F20BE.E493EC1@yahoo.com>
Date: Wed, 24 Jan 2001 13:36:46 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.4.1-pre8 i486)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: stripping symbols from modules
In-Reply-To: <FEEBE78C8360D411ACFD00D0B747797188095D@xsj02.sjs.agilent.com> <94m11u$3re$1@cesium.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:

>Is there any way to export only
> > selected symbols as required by insmod ? As of now I am not worried
> > about ksymoops.
> >
> 
> I think "strip --strip-unneeded" is what you want.
> 

I think you will find "--strip-unneeded" will toss out init_module
and cleanup_module (and perhaps others). Using "strip -g -x ..."
would leave the important bits in place IIRC (at least on 2.2.x).

Paul.



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
