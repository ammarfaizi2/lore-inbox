Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130432AbRCIC7L>; Thu, 8 Mar 2001 21:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130433AbRCIC7G>; Thu, 8 Mar 2001 21:59:06 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:23087 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S130432AbRCIC6t>; Thu, 8 Mar 2001 21:58:49 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Rob Cermak <cermak@imcs.rutgers.edu>
cc: linux-kernel@vger.kernel.org, chris.ricker@genetics.utah.edu
Subject: Re: [PATCH] Documentation/Changes & hunting 
In-Reply-To: Your message of "Thu, 08 Mar 2001 21:00:25 CDT."
             <Pine.SOL.4.21.0103082052430.902-100000@imcs.rutgers.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 09 Mar 2001 13:58:09 +1100
Message-ID: <11307.984106689@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Mar 2001 21:00:25 -0500 (EST), 
Rob Cermak <cermak@IMCS.rutgers.edu> wrote:
>Included some info on things needed to compile 2.4.2-ac16.   Feel free to
>further edit and comment.  Patched against -ac16.   [linux = ac16; my
>edited version is ac14].
>+o  flex                   2.5.4                   # flex --version
>+o  bison                  1.28                    # bison --version
>+o  db                     3.1.17 (1)              # strings /lib/libdb.so | grep Sleep | grep DB
>+o  yacc                   (2)

No.  Building the kernel must not rely on userspace tools like yacc and
lex and certainly not on db.  The fact that aic7xxx requires these
tools is a problem for aic7xxx, not for the entire kernel.  We are
working on fixing aic7xxx to build without the user space tools.

