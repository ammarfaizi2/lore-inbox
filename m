Return-Path: <linux-kernel-owner+w=401wt.eu-S932694AbWLSJCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932694AbWLSJCG (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 04:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932697AbWLSJCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 04:02:05 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:65359 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932694AbWLSJCD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 04:02:03 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH] Fix sparsemem on Cell
Date: Tue, 19 Dec 2006 09:59:45 +0100
User-Agent: KMail/1.9.5
Cc: linuxppc-dev@ozlabs.org,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>, kmannth@us.ibm.com,
       linux-kernel@vger.kernel.org, hch@infradead.org, linux-mm@kvack.org,
       paulus@samba.org, mkravetz@us.ibm.com, gone@us.ibm.com,
       cbe-oss-dev@ozlabs.org
References: <20061215165335.61D9F775@localhost.localdomain> <200612182354.47685.arnd@arndb.de> <1166483780.8648.26.camel@localhost.localdomain>
In-Reply-To: <1166483780.8648.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612190959.47344.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 December 2006 00:16, Dave Hansen wrote:
> How about an enum, or a pair of #defines?
> 
> enum context
> {
>         EARLY,
>         HOTPLUG
> };

Sounds good, but since this is in a global header file, it needs
to be in an appropriate name space, like

enum memmap_context {
	MEMMAP_EARLY,
	MEMMAP_HOTPLUG,
};

	Arnd <><
