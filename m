Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbUAIOr0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 09:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbUAIOr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 09:47:26 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:37384 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261827AbUAIOrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 09:47:24 -0500
Date: Fri, 9 Jan 2004 14:47:23 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       heiko.carstens@de.ibm.com
Subject: Re: 2.6.1-mm1
Message-ID: <20040109144723.A24989@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, heiko.carstens@de.ibm.com
References: <20040109014003.3d925e54.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040109014003.3d925e54.akpm@osdl.org>; from akpm@osdl.org on Fri, Jan 09, 2004 at 01:40:03AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 09, 2004 at 01:40:03AM -0800, Andrew Morton wrote:
> - A large s390 update.  Various device drivers and IO layer changes there.

The zfcp driver adds a __setup function and lots of idef MODULE code.
Please don't do this for new driver (zfcp is new in 2.6).  the proper
module_param macros work for both modular and builtin use.

adding MODULE ifdefs is a lartable offense :)
