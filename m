Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264926AbSJVTZX>; Tue, 22 Oct 2002 15:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264938AbSJVTZX>; Tue, 22 Oct 2002 15:25:23 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:43557 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S264926AbSJVTX7>; Tue, 22 Oct 2002 15:23:59 -0400
Date: Tue, 22 Oct 2002 14:29:52 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Gerrit Huizenga <gh@us.ibm.com>, Andrew Morton <akpm@digeo.com>
cc: Rik van Riel <riel@conectiva.com.br>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch 
Message-ID: <190260000.1035314992@baldur.austin.ibm.com>
In-Reply-To: <E1844MH-00027H-00@w-gerrit2>
References: <E1844MH-00027H-00@w-gerrit2>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Tuesday, October 22, 2002 12:06:29 -0700 Gerrit Huizenga
<gh@us.ibm.com> wrote:

> If the shared pte patch had mmap support, then all shared libraries
> would benefit.  Might need to align them to 4 MB boundaries for best
> results, which would also be easy for libraries with unspecified
> attach addresses (e.g. most shared libraries).

Shared page tables do support mmap, but only for areas that are marked
shared.  Private mappings are only shared at fork time.  If shared
libraries are mapped shared, then shared page tables will actively share
pte pages for them.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

