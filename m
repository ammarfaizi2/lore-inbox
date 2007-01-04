Return-Path: <linux-kernel-owner+w=401wt.eu-S932248AbXADEjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbXADEjf (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 23:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbXADEjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 23:39:35 -0500
Received: from ricci.tusc.com.au ([203.2.177.24]:19983 "EHLO ricci.tusc.com.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932248AbXADEje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 23:39:34 -0500
Subject: [PATCH] X.25: Trivial, SOCK_DEBUG's in x25_facilities missing
	newlines
From: ahendry <ahendry@tusc.com.au>
To: linux-x25@vger.kernel.org, eis@baty.hanse.de
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 04 Jan 2007 15:39:24 +1100
Message-Id: <1167885564.5124.98.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial. Newlines missing on the SOCK_DEBUG's for X.25 facility negotiation.

Signed-off-by: Andrew Hendry <andrew.hendry@gmail.com>


--- linux-2.6.19-vanilla/net/x25/x25_facilities.c	2006-12-31 22:31:07.000000000 +1100
+++ linux-2.6.19/net/x25/x25_facilities.c	2007-01-01 22:56:17.000000000 +1100
@@ -254,7 +254,7 @@ int x25_negotiate_facilities(struct sk_b
 	 *	They want reverse charging, we won't accept it.
 	 */
 	if ((theirs.reverse & 0x01 ) && (ours->reverse & 0x01)) {
-		SOCK_DEBUG(sk, "X.25: rejecting reverse charging request");
+		SOCK_DEBUG(sk, "X.25: rejecting reverse charging request\n");
 		return -1;
 	}
 
@@ -262,29 +262,29 @@ int x25_negotiate_facilities(struct sk_b
 
 	if (theirs.throughput) {
 		if (theirs.throughput < ours->throughput) {
-			SOCK_DEBUG(sk, "X.25: throughput negotiated down");
+			SOCK_DEBUG(sk, "X.25: throughput negotiated down\n");
 			new->throughput = theirs.throughput;
 		}
 	}
 
 	if (theirs.pacsize_in && theirs.pacsize_out) {
 		if (theirs.pacsize_in < ours->pacsize_in) {
-			SOCK_DEBUG(sk, "X.25: packet size inwards negotiated down");
+			SOCK_DEBUG(sk, "X.25: packet size inwards negotiated down\n");
 			new->pacsize_in = theirs.pacsize_in;
 		}
 		if (theirs.pacsize_out < ours->pacsize_out) {
-			SOCK_DEBUG(sk, "X.25: packet size outwards negotiated down");
+			SOCK_DEBUG(sk, "X.25: packet size outwards negotiated down\n");
 			new->pacsize_out = theirs.pacsize_out;
 		}
 	}
 
 	if (theirs.winsize_in && theirs.winsize_out) {
 		if (theirs.winsize_in < ours->winsize_in) {
-			SOCK_DEBUG(sk, "X.25: window size inwards negotiated down");
+			SOCK_DEBUG(sk, "X.25: window size inwards negotiated down\n");
 			new->winsize_in = theirs.winsize_in;
 		}
 		if (theirs.winsize_out < ours->winsize_out) {
-			SOCK_DEBUG(sk, "X.25: window size outwards negotiated down");
+			SOCK_DEBUG(sk, "X.25: window size outwards negotiated down\n");
 			new->winsize_out = theirs.winsize_out;
 		}
 	}

