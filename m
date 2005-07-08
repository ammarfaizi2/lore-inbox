Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262615AbVGHFdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbVGHFdf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 01:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262618AbVGHFdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 01:33:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:6607 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262615AbVGHFdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 01:33:33 -0400
Subject: Re: [PATCH] audit: file system auditing based on location and name
From: Arjan van de Ven <arjan@infradead.org>
To: serue@us.ibm.com
Cc: "Timothy R. Chavez" <tinytim@us.ibm.com>, Steve Grubb <sgrubb@redhat.com>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-audit@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
       Mounir Bsaibes <mbsaibes@us.ibm.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Klaus Weidner <klaus@atsec.com>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, Robert Love <rml@novell.com>,
       Christoph Hellwig <hch@infradead.org>,
       Daniel H Jones <danjones@us.ibm.com>, Amy Griffis <amy.griffis@hp.com>,
       Maneesh Soni <maneesh@in.ibm.com>
In-Reply-To: <20050707225136.GA27099@serge.austin.ibm.com>
References: <1120668881.8328.1.camel@localhost>
	 <200507071548.37996.sgrubb@redhat.com>
	 <1120771909.3198.32.camel@laptopd505.fenrus.org>
	 <200507071708.32451.tinytim@us.ibm.com>
	 <20050707225136.GA27099@serge.austin.ibm.com>
Content-Type: text/plain
Date: Fri, 08 Jul 2005 07:33:15 +0200
Message-Id: <1120800795.3249.5.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > [foo@liltux /]$ cat /etc/shadow
> > cat: /etc/shadow: Permission denied
> 
> Additionally, the apps would need to either be rewritten to create
> the files under the audited context, or policy would have to cause all
> files created by those apps to be under the audited context.  Neither
> one of those options is satisfactory

why not?
If your /etc/shadow has no selinux context you've lost already :0


