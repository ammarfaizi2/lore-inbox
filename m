Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262088AbUJZDr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbUJZDr7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 23:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbUJZDoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 23:44:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56201 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262174AbUJZDnj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 23:43:39 -0400
Date: Mon, 25 Oct 2004 20:36:02 -0700
From: "David S. Miller" <davem@redhat.com>
To: Patrick Caulfield <pcaulfie@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-decnet-user@lists.sourceforge.net
Subject: Re: [PATCH] DECnet connect hang bugfix
Message-Id: <20041025203602.3d238268.davem@redhat.com>
In-Reply-To: <20041024111157.GA31630@tykepenguin.com>
References: <20041024111157.GA31630@tykepenguin.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Oct 2004 12:11:57 +0100
Patrick Caulfield <pcaulfie@redhat.com> wrote:

> This patch fixes a bug in the DECnet connect that seems to have been in 2.6 for
> a while now.
> 
> If a connection is rejected by a remote host (eg invalid access control, no
> such object etc) the Linux end hangs in connect() because it is only waiting for
> the socket to go into RUN state.
> 
> This patch sets the ECONNREFUSED error state on the socket when the connection
> is rejected to that the connect() exits it's wait loop and returns the error to
> the user.

Applied, thanks Patrick.

Could you please provide proper "Signed-off-by:" lines with
future DECNET patches?

Thanks a lot.
