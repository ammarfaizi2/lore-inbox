Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbUEQQZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUEQQZk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 12:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbUEQQZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 12:25:40 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:17874 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S261500AbUEQQZj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 12:25:39 -0400
Date: Mon, 17 May 2004 18:17:38 +0200
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6 breaks kmail (nfs related?)
Message-ID: <20040517161738.GA11009@janus>
Mail-Followup-To: Frank van Maarseveen <frankvm@xs4all.nl>,
	linux-kernel@vger.kernel.org
References: <200405131411.52336.amann@physik.tu-berlin.de> <200405170335.42754.norberto+linux-kernel@bensa.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405170335.42754.norberto+linux-kernel@bensa.ath.cx>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2004 at 03:35:42AM -0300, Norberto Bensa wrote:
> 
> Well, I'm getting this with kcalc after upgrading to 2.6.6-mm3:
> 
> $ kcalc
> KCrash: Application 'kcalc' crashing...
> 
> strace shows lots of 
> ...
> close(1002)                             = -1 EBADF (Bad file descriptor)
> close(1003)                             = -1 EBADF (Bad file descriptor)
> close(1004)                             = -1 EBADF (Bad file descriptor)
> close(1005)                             = -1 EBADF (Bad file descriptor)

Looks like daemonizing code to me, getting rid of open fds.

-- 
Frank
