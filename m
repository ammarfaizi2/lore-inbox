Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262791AbVDAPkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbVDAPkM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 10:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262785AbVDAPjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 10:39:03 -0500
Received: from smtp9.poczta.onet.pl ([213.180.130.49]:59833 "EHLO
	smtp9.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S262773AbVDAPhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 10:37:21 -0500
Message-ID: <424D6B54.2090200@poczta.onet.pl>
Date: Fri, 01 Apr 2005 17:40:04 +0200
From: Wiktor <victorjan@poczta.onet.pl>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050329)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFD] 'nice' attribute for executable files
References: <200503311556.j2VFu9Hc007903@laptop11.inf.utfsm.cl>
In-Reply-To: <200503311556.j2VFu9Hc007903@laptop11.inf.utfsm.cl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> 
> Even better: Write a C wrapper for each affected program that just renices
> it as needed.

I suggest to implement scalable solution, so the final user wont't have 
to write separate wrapper for *each* program. universal wrapper is 
better solution, but (now i know, that implementing something that can 
be dangerous if used incorrectly is so evil, that only the devil could 
have proposed it) it forces use of database (that normally would be kept 
in filesystem's file metadata) and if some-malicious-person would have 
accessed it in write mode (as result of wrong file permissions), the 
system performerance would be in danger. in my solution, there is 
per-file attribute, accessible only for root, and if hacker has root 
permissions, existence of nice attribute is meaningless.

--
wixor
May the Source be with you.
