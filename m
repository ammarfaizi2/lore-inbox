Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286744AbRLVJOP>; Sat, 22 Dec 2001 04:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286745AbRLVJOB>; Sat, 22 Dec 2001 04:14:01 -0500
Received: from rj.sgi.com ([204.94.215.100]:24757 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S286744AbRLVJNs>;
	Sat, 22 Dec 2001 04:13:48 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Jason Thomas <jason@topic.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] link errors with internal calls to devexit functions 
In-Reply-To: Your message of "Sat, 22 Dec 2001 10:04:19 BST."
             <Pine.LNX.4.33.0112220953400.1352-100000@vaio> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 22 Dec 2001 20:13:37 +1100
Message-ID: <7928.1009012417@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Dec 2001 10:04:19 +0100 (CET), 
Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> wrote:
>I'd rather think that the patch (and the original code) is broken, as it
>seems we call an __devexit function from an init function. So 
>the correct fix is to remove the __devexit attribute from the offending 
>functions.

Andrew Morton said the same thing and I agree.  The code is broken, no
amount of fancy wrappers will fix that.  This is the perfect example of
why the new binutils are good, they are catching broken code.

