Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946060AbWGPBHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946060AbWGPBHP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 21:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946062AbWGPBHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 21:07:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:8128 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1946060AbWGPBHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 21:07:14 -0400
Subject: Re: raid io requests not parallel?
From: Arjan van de Ven <arjan@infradead.org>
To: Jonathan Baccash <jbaccash@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <e0e4cb3e0607151704o479371afpc9332a08fb84ba09@mail.gmail.com>
References: <e0e4cb3e0607151704o479371afpc9332a08fb84ba09@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 16 Jul 2006 03:07:12 +0200
Message-Id: <1153012032.3033.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So.... why doesn't the raid issue the writes in parallel? 

because you use O_DIRECT, which means your application waits for the
write to hit the disk before doing the next write ;)


