Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVDQK3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVDQK3V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 06:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVDQK3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 06:29:20 -0400
Received: from [194.90.79.130] ([194.90.79.130]:41490 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S261294AbVDQK3Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 06:29:16 -0400
Subject: Re: More performance for the TCP stack by using additional
	hardware chip on NIC
From: Avi Kivity <avi@argo.co.il>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andreas Hartmann <andihartmann@01019freenet.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1113728880.17394.16.camel@laptopd505.fenrus.org>
References: <d3t63d$3qe$1@pD9F86D3F.dip0.t-ipconnect.de>
	 <1113728880.17394.16.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Message-Id: <1113733753.15803.26.camel@avik.scalemp>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 17 Apr 2005 13:29:14 +0300
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Apr 2005 10:29:15.0026 (UTC) FILETIME=[4DABC720:01C54338]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-04-17 at 12:07, Arjan van de Ven wrote:
> On Sun, 2005-04-17 at 10:17 +0200, Andreas Hartmann wrote:
> > Hello!
> > 
> > Alacritech developed a new chip for NIC's
> > (http://www.alacritech.com/html/tech_review.html), which makes it possible
> > to take away the TCP stack from the host CPU. Therefore, the host CPU has
> > more performance for the applications according Alacritech.
> 
> there are very many good reasons why this for linux is not the right
> solution, including the fact that the linux tcp/ip stack already is
> quite fast so the "gains" achieved aren't that stellar as the gains you
> get when comparing to windows.
> 

TOEs can remove the data copy on receive. In some applications (notably
storage), where the application does not touch most of the data, this is
a significant advantage that cannot be achieved in a software-only
solution.


> Also these types of solution always add quite a bit of overhead to
> connection setup/teardown making it actually a *loss* for the "many
> short connections" types of workloads. Now guess which things certain
> benchmarks use, and guess what real world servers do :)
> 

again, this depends on the application.

a copyless solution is probably necessary to achieve 10Gb/s speeds.

Avi

