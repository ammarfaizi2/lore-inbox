Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264386AbUIZW27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbUIZW27 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 18:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUIZW27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 18:28:59 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:56230 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S264386AbUIZW25
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 18:28:57 -0400
Date: Mon, 27 Sep 2004 00:28:56 +0200
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: Christian Fischer <Christian.Fischer@fischundfischer.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS TUNING: #define NFS3_MAXGROUPS
Message-ID: <20040926222856.GA22758@janus>
References: <200409261638.36011.Christian.Fischer@fischundfischer.com> <200409261643.29571.Christian.Fischer@fischundfischer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409261643.29571.Christian.Fischer@fischundfischer.com>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2004 at 04:43:29PM +0200, Christian Fischer wrote:
> On Sunday 26 September 2004 16:38, Christian Fischer wrote:
> > Hello.
> >
> > Please can you tell me if  NFS_MAXGROUPS is tunable for linux kernel? (and
> > is it safe?) I need more than 16 groups per user. For BSD-kernel it is a
> > tunable constant (i think so) and I'm not so familar with such things.

That limit is hardcoded in the SUNRPC protocol (part of NFS) and
_cannot_ be changed: it is a fundamental constant in NFS with AUTH_UNIX
authentication. However, there is a trick to bypass this protocol
limitation, see http://www.frankvm.com/nfs-ngroups for a 2.4.x patch.

The 2.6.x patch is under development.

-- 
Frank
