Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265494AbUFOMxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265494AbUFOMxZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 08:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265499AbUFOMxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 08:53:25 -0400
Received: from hostmaster.org ([212.186.110.32]:54172 "HELO hostmaster.org")
	by vger.kernel.org with SMTP id S265494AbUFOMxY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 08:53:24 -0400
Subject: Re: NUMA API observations
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20040614153638.GB25389@krispykreme>
References: <20040614153638.GB25389@krispykreme>
Content-Type: text/plain
Message-Id: <1087304002.28142.46.camel@hostmaster.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 15 Jun 2004 14:53:22 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at these numastat results and the default policy it seems that
memory is primarily allocated on the first node which in turn means a
unnecessarily large amount of page faults on the second node.

I wonder if it is possible to better balance processes among the nodes
by e.g. setting nodeAffinity = pid mod nodeCount

Tom

-- 
  T h o m a s   Z e h e t b a u e r   ( TZ251 )
  PGP encrypted mail preferred - KeyID 96FFCB89
      finger thomasz@hostmaster.org for key

Attempting to apply the OSI layers model to a real network is just like
attempting to represent seven dimensions in four dimensional reality.
      Thomas Zehetbauer

