Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVFVLk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVFVLk3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 07:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVFVLk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 07:40:29 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:60842 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S261155AbVFVLkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 07:40:23 -0400
Subject: Re: [patch 1/2] selinux: add executable stack check
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, jmorris@redhat.com
In-Reply-To: <20050622015156.AAD7056C876@estila.tuxedo-es.org>
References: <20050622015156.AAD7056C876@estila.tuxedo-es.org>
Content-Type: text/plain; charset=utf-8
Organization: National Security Agency
Date: Wed, 22 Jun 2005 07:39:03 -0400
Message-Id: <1119440343.13181.2.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-22 at 03:51 +0200, Lorenzo Hernández García-Hierro
wrote:
> This patch adds an execstack permission check that controls the
> ability to make the main process stack executable so that attempts to
> make the stack executable can still be prevented even if the process is
> allowed the existing execmem permission in order to e.g. perform runtime
> code generation.  Note that this does not yet address thread stacks.
> Note also that unlike the execmem check, the execstack check is only
> applied on mprotect calls, not mmap calls, as the current
> security_file_mmap hook is not passed the necessary information
> presently.

> Signed-off-by: Lorenzo Hernandez Garcia-Hierro <lorenzo@gnu.org>
> ---
> 
>  security/selinux/hooks.c                     |   10 ++++++++++
>  security/selinux/include/av_perm_to_string.h |    1 +
>  security/selinux/include/av_permissions.h    |    1 +
>  3 files changed, 12 insertions(+)

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

-- 
Stephen Smalley
National Security Agency

