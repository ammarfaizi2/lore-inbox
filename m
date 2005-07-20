Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVGTSJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVGTSJb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 14:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbVGTSJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 14:09:31 -0400
Received: from gate.in-addr.de ([212.8.193.158]:5790 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261442AbVGTSJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 14:09:30 -0400
Date: Wed, 20 Jul 2005 20:09:18 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: "Walker, Bruce J (HP-Labs)" <bruce.walker@hp.com>,
       linux clustering <linux-cluster@redhat.com>,
       David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
       clusters_sig@lists.osdl.org
Subject: Re: [Clusters_sig] RE: [Linux-cluster] Re: [Ocfs2-devel] [RFC] nodemanager, ocfs2, dlm
Message-ID: <20050720180918.GU5416@marowsky-bree.de>
References: <3689AF909D816446BA505D21F1461AE404167CFB@cacexc04.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3689AF909D816446BA505D21F1461AE404167CFB@cacexc04.americas.cpqcorp.net>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-07-20T09:55:31, "Walker, Bruce J (HP-Labs)" <bruce.walker@hp.com> wrote:

> Like Lars, I too was under the wrong impression about this configfs
> "nodemanager" kernel component.  Our discussions in the cluster
> meeting Monday and Tuesday were assuming it was a general service that
> other kernel components could/would utilize and possibly also
> something that could send uevents to non-kernel components wanting a
> std. way to see membership information/events.

Let me clarify that this was something we briefly touched on in
Walldorf: The node manager would (re-)export the current data via sysfs
(which would result in uevents being sent, too), and not something we
dreamed up just Monday ;-)

> As to kernel components without corresponding user-level "managers",
> look no farther than OpenSSI.  Our hope was that we could adapt to a
> user-land membership service and this interface thru configfs would
> drive all our kernel subsystems.

Well, node manager still can provide you the input as to which nodes are
configured, which in a way translates to "membership". The thing it
doesn't seem to provide yet is the supsend/modify/resume cycle which for
example the RHAT DLM seems to require.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

