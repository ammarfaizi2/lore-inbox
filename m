Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWEITGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWEITGK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 15:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbWEITGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 15:06:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22672 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751222AbWEITGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 15:06:09 -0400
Date: Tue, 9 May 2006 20:04:57 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Tillmann Steinbrecher <tsteinbr@igd.fraunhofer.de>
Cc: linux-kernel@vger.kernel.org, dm-crypt@saout.de
Subject: Re: [dm-crypt] dm-crypt is broken and causes massive data corruption
Message-ID: <20060509190457.GL16180@agk.surrey.redhat.com>
Mail-Followup-To: Tillmann Steinbrecher <tsteinbr@igd.fraunhofer.de>,
	linux-kernel@vger.kernel.org, dm-crypt@saout.de
References: <445F7DCC.2000508@igd.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <445F7DCC.2000508@igd.fraunhofer.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 07:20:12PM +0200, Tillmann Steinbrecher wrote:
> it's been many months that dm-crypt has been broken, and is known to 
> cause massive data corruption.
 
> Various people have noticed this, have lost data and wasted many hours 
> trying to find the reason, and still NOTHING is being done about it. 

Perhaps that's because it wasn't until last week that the upstream
maintainers heard of these problems?

So far there isn't much in the way of controlled experiments, but:

  All the reports agree the problem is independent of filesystem.

  One thread suggests only filesystem metadata is corrupted, not file
  data, and wonders if something's going wrong with (unsupported) write 
  barriers.

  Another report said dm-crypt over raid5 failed while raid5 
  over dm-crypt worked.

Alasdair
-- 
agk@redhat.com
