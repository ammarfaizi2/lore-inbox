Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbTENGOG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 02:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbTENGOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 02:14:06 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:25869 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S262050AbTENGOD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 02:14:03 -0400
Date: Wed, 14 May 2003 00:26:48 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ahc_linux_map_seg() compile/style/data corruption fixes
Message-ID: <504652704.1052893608@aslan.scsiguy.com>
In-Reply-To: <20030514062134.GG2444@holomorphy.com>
References: <20030514044934.GC29926@holomorphy.com> <498302704.1052893137@aslan.scsiguy.com> <20030514062134.GG2444@holomorphy.com>
X-Mailer: Mulberry/3.0.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> For the connoisseur, I've attached before/after disassemblies
>>> demonstrating that the if () whose failure is caused by (2) is a very,
>>> very, very real problem.
> 
> On Wed, May 14, 2003 at 12:18:57AM -0600, Justin T. Gibbs wrote:
>> This was obvious from code inspection.
> 
> ISTR a debate where it was claimed the constant would be implicitly
> promoted.

Promotion to long is all that is guaranteed at least up to C89.  I
don't think that C99 has changed this.  The use of ULL in the code
is required.

--
Justin

