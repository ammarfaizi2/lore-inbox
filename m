Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284704AbRLXLDW>; Mon, 24 Dec 2001 06:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284711AbRLXLDM>; Mon, 24 Dec 2001 06:03:12 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:5138 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S284704AbRLXLC6>;
	Mon, 24 Dec 2001 06:02:58 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        "H . J . Lu" <hjl@lucon.org>
Subject: Re: How to fix false positives on references to discarded text/data? 
In-Reply-To: Your message of "Mon, 24 Dec 2001 11:05:00 BST."
             <Pine.LNX.4.33.0112241055380.1676-100000@vaio> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 24 Dec 2001 22:02:45 +1100
Message-ID: <29350.1009191765@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Dec 2001 11:05:00 +0100 (CET), 
Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> wrote:
>According to my reading of the docs and also to my testing, .subsection 0 
>and .previous should be equivalent here. But .subsection 0 may be cleaner.

As I read the gas info text, .subsection changes the current entry on
top of stack, it does not stack a new section/subsection pair.
.previous swaps the top of stack with the previous top of stack.  I
suspect that you would get different results if there was more than one
section on the stack.  In any case, .subsection 0 is "obviously correct".

