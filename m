Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVFVLkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVFVLkw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 07:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVFVLkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 07:40:51 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:2987 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S261157AbVFVLko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 07:40:44 -0400
Subject: Re: [patch 2/2] selinux: add executable heap check
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, jmorris@redhat.com
In-Reply-To: <20050622015158.346C856C87A@estila.tuxedo-es.org>
References: <20050622015158.346C856C87A@estila.tuxedo-es.org>
Content-Type: text/plain; charset=utf-8
Organization: National Security Agency
Date: Wed, 22 Jun 2005 07:39:35 -0400
Message-Id: <1119440375.13181.4.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-22 at 03:51 +0200, Lorenzo Hernández García-Hierro
wrote:
> This patch,based on sample code by Roland McGrath, adds an execheap
> permission check that controls the ability to make the heap executable
> so that this can be prevented in almost all cases (the X server is
> presently an exception, but this will hopefully be resolved in the future)
> so that even programs with execmem permission will need to have the anonymous
> memory mapped in order to make it executable. 
> The only reason that we use a permission check for such restriction
> (vs. making it unconditional) is that the X module loader presently
> needs it; it could possibly be made unconditional in the future when
> X is changed.

> Signed-off-by: Lorenzo Hernandez Garcia-Hierro <lorenzo@gnu.org>
> ---
> 
>  security/selinux/hooks.c                     |   11 +++++++++++
>  security/selinux/include/av_perm_to_string.h |    1 +
>  security/selinux/include/av_permissions.h    |    1 +
>  3 files changed, 13 insertions(+)

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

-- 
Stephen Smalley
National Security Agency

