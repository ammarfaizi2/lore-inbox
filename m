Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264507AbTEPRU4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 13:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264508AbTEPRU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 13:20:56 -0400
Received: from pimout4-ext.prodigy.net ([207.115.63.103]:53133 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264507AbTEPRUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 13:20:55 -0400
From: Eugene Weiss <eweiss@sbcglobal.net>
Reply-To: eweiss@sbcglobal.net
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] submount: another removeable media handler
Date: Fri, 16 May 2003 10:31:47 -0400
User-Agent: KMail/1.5
References: <200305160106.37274.eweiss@sbcglobal.net> <20030516113304.GK32559@Synopsys.COM>
In-Reply-To: <20030516113304.GK32559@Synopsys.COM>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200305161027.20045.eweiss@sbcglobal.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> how is it different from what automounter does?

Autofs works by creating a special filesystem above the vfs layer, and passing 
requests and data back and forth.   Submount actually does much less than 
this- it puts a special filesystem underneath the real one, and the only 
things it returns to the VFS layer are error messages.  It handles no IO 
operations whatsoever.

Peter Anvin has called using the automounter for removeable media "abuse."
Submount is designed for it.


