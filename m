Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbTENGPz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 02:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTENGPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 02:15:50 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:26127 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262117AbTENGPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 02:15:19 -0400
Date: Wed, 14 May 2003 07:28:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Miles Bader <miles@gnu.org>
Cc: Christopher Hoover <ch@murgatroid.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.68 FUTEX support should be optional
Message-ID: <20030514072802.A2787@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miles Bader <miles@gnu.org>, Christopher Hoover <ch@murgatroid.com>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <20030513213157.A1063@heavens.murgatroid.com> <20030514071446.A2647@infradead.org> <buofzniujzt.fsf@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <buofzniujzt.fsf@mcspd15.ucom.lsi.nec.co.jp>; from miles@lsi.nec.co.jp on Wed, May 14, 2003 at 03:20:54PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 03:20:54PM +0900, Miles Bader wrote:
> Are futexes unusable without an MMU (I don't know anything about the
> implementation)?

The futex implementation relies heavily on follow_page() which is stubbed out
for nommu builds.

