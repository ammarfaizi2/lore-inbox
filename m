Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261354AbSLPVSu>; Mon, 16 Dec 2002 16:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261356AbSLPVSu>; Mon, 16 Dec 2002 16:18:50 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:55567 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S261354AbSLPVSt>;
	Mon, 16 Dec 2002 16:18:49 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to do -nostdinc? 
In-reply-to: Your message of "Mon, 16 Dec 2002 19:29:19 BST."
             <20021216182919.GA1607@mars.ravnborg.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 17 Dec 2002 08:26:33 +1100
Message-ID: <20218.1040073993@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2002 19:29:19 +0100, 
Sam Ravnborg <sam@ravnborg.org> wrote:
>On Sun, Dec 15, 2002 at 11:06:41PM +1100, Keith Owens wrote:
>> There are two ways of setting the -nostdinc flag in the kernel Makefile :-
>> 
>> (1) -nostdinc $(shell $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')
>> (2) -nostdinc -iwithprefix include
>> 
>> The first format breaks with non-English locales, however the fix is trivial.
>> 
>> (1a) -nostdinc $(shell LANG=C $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')
>> 
>Hi Keith.
>
>Based on the comments received, solution (2) seems to be OK.
>Do you agree?

Does gcc still mark -iwithprefix as deprecated?  If it does then do not
rely on it and use (1a).  If gcc will support -iwithprefix then use (2).

