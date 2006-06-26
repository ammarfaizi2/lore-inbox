Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030315AbWFZPjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030315AbWFZPjl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 11:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030356AbWFZPjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 11:39:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38843 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030315AbWFZPjk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 11:39:40 -0400
Date: Mon, 26 Jun 2006 11:38:35 -0400
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
Message-ID: <20060626153834.GA18599@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060626151012.GR23314@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060626151012.GR23314@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 05:10:12PM +0200, Adrian Bunk wrote:
 > virt_to_bus/bus_to_virt are long deprecated, mark them as __deprecated 
 > on i386.
 > 
 > Without such warnings people will never update their code and fix 
 > the errors in PPC64 builds.

.. and deprecating pm_send_all, cli, sti, restore_flags, check_region yadayada
has really been a great success at motivating people to fix those up too.

How about we fix up some of the existing noise before we add more?
A build log of a fedora kernel I had handy shows 165 deprecated warnings
that have been there forever.  Your proposal will add over 500 warnings
in drivers/ alone.

		Dave

-- 
http://www.codemonkey.org.uk
