Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275268AbTHMP5f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 11:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275269AbTHMP5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 11:57:35 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:63903 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S275268AbTHMP5b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 11:57:31 -0400
Subject: Ltp regression test results for 2.6.0-test3, bk1, mm1, mm2
From: Paul Larson <plars@linuxtestproject.org>
To: lkml <linux-kernel@vger.kernel.org>,
       ltp-results <ltp-results@lists.sourceforge.net>, linstab@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 13 Aug 2003 10:57:14 -0500
Message-Id: <1060790234.27851.2883.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the results of some automated nightly regression tests I've
been running with LTP.  This is similar to what Mark Peloquin has been
releasing here, but with a focus on LTP functional/regression testing
rather than performance.  For right now, this just includes the
runalltests.sh script, but may be expanded to include other LTP (and
possibly non-ltp) tests in the future.  These tests are all done on a
4-way PIII 700, 4GB, debian unstable, with frequent updates and
refreshes of the LTP cvs tree.  There are also detailed results and
system info you can browse to from the links listed below.  Please let
me know if this is useful and how it can be made more useful.

Thanks,
Paul Larson

2.6.0-test3 vs 2.6.0-test3-bk1
http://developer.osdl.org/dev/ltp/results/2.6.0-test3-vs-2.6.0-test3-bk1/
Test Name      2.6.0-test3        2.6.0-test3-bk1     Regression  Improvement
-----------------------------------------------------------------------------
alarm03        FAIL               FAIL                    N            N
getgroups03    FAIL               FAIL                    N            N
nanosleep02    FAIL               FAIL                    N            N
setegid01      FAIL               FAIL                    N            N
swapoff01      FAIL               FAIL                    N            N
swapoff02      FAIL               FAIL                    N            N

2.6.0-test3 vs 2.6.0-test3-mm1
http://developer.osdl.org/dev/ltp/results/2.6.0-test3-vs-2.6.0-test3-mm1/
Test Name      2.6.0-test3        2.6.0-test3-mm1     Regression  Improvement
-----------------------------------------------------------------------------
alarm03        FAIL               FAIL                    N            N
getgroups03    FAIL               FAIL                    N            N
nanosleep02    FAIL               FAIL                    N            N
setegid01      FAIL               FAIL                    N            N
swapoff01      FAIL               FAIL                    N            N
swapoff02      FAIL               FAIL                    N            N


2.6.0-test3-mm1 vs 2.6.0-test3-mm2
http://developer.osdl.org/dev/ltp/results/2.6.0-test3-mm1-vs-2.6.0-test3-mm2/
Test Name      2.6.0-test3-mm1    2.6.0-test3-mm2     Regression  Improvement
-----------------------------------------------------------------------------
alarm03        FAIL               FAIL                    N            N
getgroups03    FAIL               FAIL                    N            N
nanosleep02    FAIL               FAIL                    N            N
setegid01      FAIL               PASS [1]                N            Y
swapoff01      FAIL               FAIL                    N            N
swapoff02      FAIL               FAIL                    N            N

[1] setegid started passing here because I ran an apt-get dist-upgrade
and got an updated (fixed) version of glibc between these two test
runs.  So it should be passing from now on.

