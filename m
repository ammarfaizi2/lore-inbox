Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262646AbSLTPrM>; Fri, 20 Dec 2002 10:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262662AbSLTPrM>; Fri, 20 Dec 2002 10:47:12 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:9140 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262646AbSLTPrM>; Fri, 20 Dec 2002 10:47:12 -0500
Date: Fri, 20 Dec 2002 10:55:16 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@redhat.com>
Subject: Re: PTRACE_GET_THREAD_AREA
Message-ID: <20021220105513.J27455@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <200212200832.gBK8Wfg29816@magilla.sf.frob.com> <20021220154829.GB17007@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021220154829.GB17007@nevyn.them.org>; from dan@debian.org on Fri, Dec 20, 2002 at 10:48:29AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 10:48:29AM -0500, Daniel Jacobowitz wrote:
> Eventually most or all targets will have thread-specific data
> implemented; I don't want to have to redo this for each one.

Well, but on most arches you don't need any kernel support for TLS.
On sparc32/sparc64/IA-64/s390/s390x and others you simply have one
general register reserved for it by the ABI, on Alpha you use a PAL
call.
set_thread_area/get_thread_area is IA-32/x86-64 specific.

	Jakub
