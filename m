Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWDFBHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWDFBHA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 21:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWDFBHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 21:07:00 -0400
Received: from morbo.e-centre.net ([66.154.82.3]:17128 "EHLO
	cubert.e-centre.net") by vger.kernel.org with ESMTP
	id S1751238AbWDFBG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 21:06:59 -0400
X-ASG-Debug-ID: 1144285617-22974-2-0
X-Barracuda-URL: http://10.3.1.19:8000/cgi-bin/mark.cgi
X-ASG-Orig-Subj: Re: readers-writers mutex
Subject: Re: readers-writers mutex
From: Arjan van de Ven <arjan@infradead.org>
To: Joshua Hudson <joshudson@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <bda6d13a0604051521o229de77dvb38992d6427a450c@mail.gmail.com>
References: <bda6d13a0604051521o229de77dvb38992d6427a450c@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 06 Apr 2006 03:06:55 +0200
Message-Id: <1144285616.3023.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=4.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.10542
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-05 at 15:21 -0700, Joshua Hudson wrote:
> Since we are moving from semaphores to mutex, there should be a
> mutex_rw.

should there really? We discussed this briefly during the mutex work
the conclusion was that rw_sems
1) are rare (thankfully; they're highly expensive)
2) do not have mutex semantics

so... can you explain how your rw_mutex is behaving different from an
rw_sem, and can you explain what the gains are for that conversion?
(eg for mutex it was better defined semantics, lots better debugging
(possible due to the semantics) and more performance). What is that for
rw_mutex ?


