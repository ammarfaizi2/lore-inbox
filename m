Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282945AbSACIZK>; Thu, 3 Jan 2002 03:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283006AbSACIZA>; Thu, 3 Jan 2002 03:25:00 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:23564 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S282945AbSACIYr>;
	Thu, 3 Jan 2002 03:24:47 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: "H . J . Lu" <hjl@lucon.org>, Momchil Velikov <velco@fadata.bg>,
        Oliver Xymoron <oxymoron@waste.org>, linux-kernel@vger.kernel.org
Subject: Re: Extern variables in *.c files 
In-Reply-To: Your message of "Wed, 02 Jan 2002 23:56:25 -0800."
             <3C340EA9.FE084B4C@zip.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 03 Jan 2002 19:24:33 +1100
Message-ID: <16007.1010046273@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Jan 2002 23:56:25 -0800, 
Andrew Morton <akpm@zip.com.au> wrote:
>Yup.  Problem is, we have about 1500 instances in the kernel :(

You can ignore the ~250 entries in *syms.c files.  EXPORT_SYMBOL only
needs to know if a symbol is a function or anything else, it does not
care about types at all.  You can define variables and functions with
invalid types in *syms.c without doing any damage.

