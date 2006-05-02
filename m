Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWEBAXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWEBAXt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 20:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbWEBAXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 20:23:49 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:29117 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932333AbWEBAXs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 20:23:48 -0400
Date: Tue, 2 May 2006 01:23:44 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: "Petri T. Koistinen" <petri.koistinen@iki.fi>
Cc: Davide Libenzi <davidel@xmailserver.org>, Andrew Morton <akpm@osdl.org>,
       trivial@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/eventpoll.c: initialize variable, remove warning
Message-ID: <20060502002344.GS27946@ftp.linux.org.uk>
References: <Pine.LNX.4.64.0605020000050.5245@joo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605020000050.5245@joo>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 12:01:51AM +0300, Petri T. Koistinen wrote:
> From: Petri T. Koistinen <petri.koistinen@iki.fi>
> 
> Remove compiler warning by initializing uninitialized variable.

NAK, fd is initialized by ep_getfd() in all cases when it returns 0.
In case if ep_getfd() returns non-zero, fd is never used.
