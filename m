Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbTELQVw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 12:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbTELQVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 12:21:52 -0400
Received: from siaag1ad.compuserve.com ([149.174.40.6]:5332 "EHLO
	siaag1ad.compuserve.com") by vger.kernel.org with ESMTP
	id S262270AbTELQVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 12:21:50 -0400
Date: Mon, 12 May 2003 12:32:16 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Two RAID1 mirrors are faster than three
To: Clemens Schwaighofer <cs@tequila.co.jp>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <200305121234_MC3-1-3882-CFED@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clemens Schwaighofer wrote:

> Why three drives in a Raid1? Raid one is just mirror, or is the third
> drive like a "hot" replace drive if one of the others fail?

  The goal is to get better (read) performance, as well as extra
redundancy.  The system is supposed to balance reads among the
available drives but in this case it breaks when there are more
than two disks.

  I have a "changes way too much code" patch that fixes this; guess
I should at least post it and see what happens...


