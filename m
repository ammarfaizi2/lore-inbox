Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbTLLW2x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 17:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbTLLW2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 17:28:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:60096 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262446AbTLLW2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 17:28:40 -0500
Message-Id: <200312122228.hBCMSOZ28974@mail.osdl.org>
Date: Fri, 12 Dec 2003 14:28:21 -0800 (PST)
From: markw@osdl.org
Subject: more dbt-2 results hyperthreading on linux-2.6.0-test11
To: piggin@cyberone.com.au
cc: mingo@redhat.com, linux-kernel@vger.kernel.org,
       pgsql-hackers@postgresql.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

Here are the results of the comparisons I said I would do.

no-hyperthreading:
	http://developer.osdl.org/markw/dbt2-pgsql/282/
	- metric 2288.43
	- baseline

hyperthreading:
	http://developer.osdl.org/markw/dbt2-pgsql/278/
	- metric 1944.42
	- 15% throughput decrease
	
hyperthreading w/ Ingo's C1 patch:
	http://developer.osdl.org/markw/dbt2-pgsql/277/
	- metric 1978.39
	- 13.5% throughput decrease

hyperthreading w/ Nick's w26 patch:
	http://developer.osdl.org/markw/dbt2-pgsql/274/
	- metric 1955.91
	- 14.5% throughput decrease

It looks like there is some marginal benefit to your or Ingo's patches
with a workload like DBT-2.  I probably don't understand enough about
hyperthreading, but I wonder if there's something PostgreSQL can do to
take advantage of hyperthreading

Anyway, each link has pointers to readprofile and annotated oprofile
assembly output (if you find that useful.)  I haven't done enough tests
to have an idea of the error margin, but I wouldn't be surprised if it's
at least 1%.

Let me know if there's anything else you'd like me to try.

Thanks,
Mark
