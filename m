Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261740AbSJIORn>; Wed, 9 Oct 2002 10:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261747AbSJIORn>; Wed, 9 Oct 2002 10:17:43 -0400
Received: from [64.76.155.18] ([64.76.155.18]:7119 "EHLO alumno.inacap.cl")
	by vger.kernel.org with ESMTP id <S261740AbSJIORm>;
	Wed, 9 Oct 2002 10:17:42 -0400
Date: Wed, 9 Oct 2002 10:23:23 -0400 (CLT)
From: Robinson Maureira Castillo <rmaureira@alumno.inacap.cl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC][Call for Testers] Change of [const] char definitions
 from Kernel Janitor TODO List (Against 2.5.40)
Message-ID: <Pine.LNX.4.44.0210091017160.19850-100000@alumno.inacap.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems like my original post to the list went to /dev/null, since I 
can't find it at http://marc.theaimsgroup.com/?l=linux-kernel
so here we go again.

-- 

Hi all,

I've done a first run looking for var defs in the form:

const char *foo = "blah";
and changed that for
const char foo[] = "blah";

This came from the kerneljanitor TODO list, doing some tests, in x86 we 
get 4 less lines of asm code, since it only declares a single variable, 
against a static string and a pointer to that string in the *foo case.

Almost all changes were verified doing visual inspection, and trying to 
compile them. This is where you come in, since I don't have the hardware 
and/or cross-compilers to test each change I'm asking you people to test 
this patch and report any breakage to me, I'll wait some days for reports 
before start sending the changes to the respective maintainers

Patch is against 2.5.40, and it's located at:
<http://alumno.inacap.cl/~rmaureira/kernel/chardef.diff>

Best regards
-- 
Robinson Maureira Castillo
Asesor DAI
INACAP


