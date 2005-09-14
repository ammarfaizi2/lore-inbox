Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965173AbVINNCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965173AbVINNCc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 09:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965174AbVINNCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 09:02:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21914 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965173AbVINNCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 09:02:31 -0400
Subject: Re: [PATCH] Fix commit of ordered data buffers
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jan Kara <jack@suse.cz>, linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20050913184305.24705a98.akpm@osdl.org>
References: <20050913153024.GL30108@atrey.karlin.mff.cuni.cz>
	 <20050913184305.24705a98.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1126702928.1980.284.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 14 Sep 2005 14:02:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2005-09-14 at 02:43, Andrew Morton wrote:

> An alternative is to just lock the buffer in journal_commit_transaction(),
> if it was locked-and-dirty.  

That was my first reaction too.  We're using SWRITE so we'll end up
locking them anyway; and if synchronising against other lockers is an
issue, then locking them ourselves early is the obvious protection.

--Stephen

