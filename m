Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265779AbTGDFjD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 01:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbTGDFjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 01:39:02 -0400
Received: from holomorphy.com ([66.224.33.161]:26055 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265779AbTGDFjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 01:39:00 -0400
Date: Thu, 3 Jul 2003 22:53:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, zboszor@freemail.hu,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm1
Message-ID: <20030704055315.GW26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>,
	Helge Hafting <helgehaf@aitel.hist.no>, zboszor@freemail.hu,
	linux-kernel@vger.kernel.org
References: <3F0407D1.8060506@freemail.hu> <3F042AEE.2000202@freemail.hu> <20030703122243.51a6d581.akpm@osdl.org> <20030703200858.GA31084@hh.idb.hist.no> <20030703141508.796e4b82.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030703141508.796e4b82.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 02:15:08PM -0700, Andrew Morton wrote:
> ok.  If you're feeling keen could you please revert the cpumask_t patch.
> And please send the .config, thanks.

Zwane reproduced this and when I compiled an identical kernel for him
it went away; the only difference wsa the compiler version.

i.e. this looks like a compiler issue of some kind.

Boszormenyi, Helge, could I get compiler versions? Zwane had

<zwane:#offtopic> gcc (GCC) 3.2.2 20030222 (Red Hat Linux 3.2.2-5)
<zwane:#offtopic> Copyright (C) 2002 Free Software Foundation, Inc.
<zwane:#offtopic> This is free software; see the source for copying conditions
+.  There is NO
<zwane:#offtopic> warranty; not even for MERCHANTABILITY or FITNESS FOR A
+PARTICULAR PURPOSE.

so this looks like one of the offending compilers; the one I used that worked
was:

$ gcc --version
gcc (GCC) 3.3 (Debian)
Copyright (C) 2003 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Going over the disassemblies...


-- wli
