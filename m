Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266296AbSLTKQ3>; Fri, 20 Dec 2002 05:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266298AbSLTKQ3>; Fri, 20 Dec 2002 05:16:29 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:64785 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266296AbSLTKQ3>; Fri, 20 Dec 2002 05:16:29 -0500
Date: Fri, 20 Dec 2002 10:24:31 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Roland McGrath <roland@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: PTRACE_GET_THREAD_AREA
Message-ID: <20021220102431.A26923@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>
References: <200212200832.gBK8Wfg29816@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200212200832.gBK8Wfg29816@magilla.sf.frob.com>; from roland@redhat.com on Fri, Dec 20, 2002 at 12:32:41AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 12:32:41AM -0800, Roland McGrath wrote:
> This patch vs 2.5.51 (should apply fine to 2.5.52) adds two new ptrace
> requests for i386, PTRACE_GET_THREAD_AREA and PTRACE_SET_THREAD_AREA.
> These let another process using ptrace do the equivalent of performing
> get_thread_area and set_thread_area system calls for another thread.

I don't think ptrace is the right interface for this.  Just changed
the get_thread_area/set_thread_area to take a new first pid_t argument.

Of course you might have to check privilegues if the first argument is
non-null (i.e. not yourself).

