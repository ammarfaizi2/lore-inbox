Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267725AbTASX7w>; Sun, 19 Jan 2003 18:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267726AbTASX7w>; Sun, 19 Jan 2003 18:59:52 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:2826 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267725AbTASX7v>; Sun, 19 Jan 2003 18:59:51 -0500
Date: Mon, 20 Jan 2003 00:08:53 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [RFC][PATCH] Add LSM sysctl hook to 2.5.59
Message-ID: <20030120000853.A9023@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Stephen D. Smalley" <sds@epoch.ncsc.mil>,
	linux-kernel@vger.kernel.org, linux-security-module@wirex.com
References: <200301172154.QAA00757@moss-shockers.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301172154.QAA00757@moss-shockers.ncsc.mil>; from sds@epoch.ncsc.mil on Fri, Jan 17, 2003 at 04:54:37PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2003 at 04:54:37PM -0500, Stephen D. Smalley wrote:
> 
> This patch adds a LSM sysctl hook for controlling access to
> sysctl variables to 2.5.59, split out from the lsm-2.5 BitKeeper tree.
> SELinux uses this hook to control such accesses in accordance with the
> security policy configuration.

I'm not very happy with this hook.  This means every single security
module needs a list of all sensitive sysctl variables, i.e. we duplicate
information in (possible a large number of) different places.

What's the reason you can't just live with DAC for sysctls?

