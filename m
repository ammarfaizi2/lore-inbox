Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262628AbUKRGsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262628AbUKRGsR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 01:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbUKRGsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 01:48:17 -0500
Received: from siaag2ab.compuserve.com ([149.174.40.132]:13993 "EHLO
	siaag2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S262628AbUKRGsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 01:48:14 -0500
Date: Thu, 18 Nov 2004 01:44:18 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Six archs are missing atomic_inc_return()
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <200411180148_MC3-1-8EE2-A85D@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Six archs do not have the atomic_inc_return() macro as of 2.6.10-rc2:

  cris
  h8300
  m32r
  ppc
  ppc64
  s390

net/core/neighbour.c:neigh_alloc() uses this macro.  Does that mean these
archs can't build network configs that use it?

 (Also, some archs do not seem to parenthesize the macro enough.  Only
sparc and parisc get it right.)


--Chuck Ebbert  18-Nov-04  01:28:59
