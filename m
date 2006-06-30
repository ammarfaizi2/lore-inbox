Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbWF3SRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWF3SRU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 14:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWF3SRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 14:17:20 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:57472 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S964838AbWF3SRT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 14:17:19 -0400
Date: Fri, 30 Jun 2006 11:16:26 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Re: Linux 2.6.17.3
Message-ID: <20060630181626.GO11588@sequoia.sous-sol.org>
References: <20060630181553.GN11588@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060630181553.GN11588@sequoia.sous-sol.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 7b3837f..8c72521 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 17
-EXTRAVERSION = .2
+EXTRAVERSION = .3
 NAME=Crazed Snow-Weasel
 
 # *DOCUMENTATION*
diff --git a/net/ipv4/netfilter/ip_conntrack_proto_sctp.c b/net/ipv4/netfilter/ip_conntrack_proto_sctp.c
index 0416073..2d3612c 100644
--- a/net/ipv4/netfilter/ip_conntrack_proto_sctp.c
+++ b/net/ipv4/netfilter/ip_conntrack_proto_sctp.c
@@ -254,7 +254,7 @@ static int do_basic_checks(struct ip_con
 	}
 
 	DEBUGP("Basic checks passed\n");
-	return 0;
+	return count == 0;
 }
 
 static int new_state(enum ip_conntrack_dir dir,
diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf_conntrack_proto_sctp.c
index 0c6da49..9dab81d 100644
--- a/net/netfilter/nf_conntrack_proto_sctp.c
+++ b/net/netfilter/nf_conntrack_proto_sctp.c
@@ -259,7 +259,7 @@ static int do_basic_checks(struct nf_con
 	}
 
 	DEBUGP("Basic checks passed\n");
-	return 0;
+	return count == 0;
 }
 
 static int new_state(enum ip_conntrack_dir dir,
