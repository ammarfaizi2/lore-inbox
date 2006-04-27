Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965024AbWD0WrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbWD0WrS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 18:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737AbWD0WrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 18:47:17 -0400
Received: from ozlabs.org ([203.10.76.45]:64129 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751741AbWD0WrR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 18:47:17 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <17489.18630.75412.66803@cargo.ozlabs.ibm.com>
Date: Fri, 28 Apr 2006 08:42:14 +1000
From: Paul Mackerras <paulus@samba.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Heiko J Schick <schihei@de.ibm.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, linuxppc-dev@ozlabs.org,
       Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
Subject: Re: [PATCH 13/16] ehca: firmware InfiniBand interface
In-Reply-To: <20060427123701.GG32127@wohnheim.fh-wedel.de>
References: <4450A1C0.3080209@de.ibm.com>
	<20060427123701.GG32127@wohnheim.fh-wedel.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel writes:

> 25 parameters?  If you tell me which drugs were involved in this code,
> I know what to stay away from.

You really need to ask the firmware architects that, since this is
basically a single firmware call.

Mind you, since a lot of the parameters are used to return individual
bytes or half-words, which are then put into structures, it might be
better to pass the pointers to the structures and let the wrapper put
the values straight into the structures.

Paul.
