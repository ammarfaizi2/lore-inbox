Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262336AbVC3Q5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbVC3Q5G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 11:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVC3Q5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 11:57:05 -0500
Received: from main.gmane.org ([80.91.229.2]:33504 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262336AbVC3Q5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 11:57:01 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: [RFD] 'nice' attribute for executable files
Date: Wed, 30 Mar 2005 18:55:24 +0200
Message-ID: <yw1xpsxhvzsz.fsf@ford.inprovide.com>
References: <fa.ed33rit.1e148rh@ifi.uio.no> <E1DGNaV-0005LG-9m@be1.7eggert.dyndns.org>
 <424ACEA9.6070401@poczta.onet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 76.80-203-227.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:hgHwZsS49LFIm0AaI57OnZy2vCc=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wiktor <victorjan@poczta.onet.pl> writes:

> max renice ulimit is quite good idea, but it allows to change nice of
> *any* process user has permissions to. it could be implemented also,
> but the idea of 'nice' file attribute is to allow *only* some process
> be run with lower nice. what's more, that nice would be *always* the
> same (at process startup)!

It can be done entirely in userspace, if you want it.  Just hack your
shell to examine some extended attribute of your choice, and adjust
the nice value before executing files.  Then arrange to have the shell
run with a negative nice value.  This can be easily accomplished with
a simple wrapper, only for the shell.

-- 
Måns Rullgård
mru@inprovide.com

