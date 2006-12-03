Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760085AbWLCUqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760085AbWLCUqg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 15:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757961AbWLCUqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 15:46:35 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:13853 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1760085AbWLCUqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 15:46:35 -0500
Date: Sun, 3 Dec 2006 21:46:33 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Aucoin <Aucoin@Houston.RR.com>
cc: "'Andrew Morton'" <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: RE: la la la la ... swappiness
In-Reply-To: <200612031540.kB3FeiQI028507@ms-smtp-03.texas.rr.com>
Message-ID: <Pine.LNX.4.63.0612032137380.17489@gockel.physik3.uni-rostock.de>
References: <200612031540.kB3FeiQI028507@ms-smtp-03.texas.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Dec 2006, Aucoin wrote:

> during tar extraction ... inactive pages reaches levels as high as ~375000

So why do you want the system to swap _less_? You need to find some free 
memory for the additional processes to run in, and you have lots of 
inactive pages, so I think you want to swap out _more_ pages.

I'd suggest to temporarily add a swapfile before you update your system. 
This can even help in bringing your memory use to the state before if you 
do it like this
  - swapon additional swapfile
  - update your database software
  - swapoff swap partition
  - swapon swap partition
  - swapoff additional swapfile

Tim
