Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270204AbRHMOBT>; Mon, 13 Aug 2001 10:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270207AbRHMOBJ>; Mon, 13 Aug 2001 10:01:09 -0400
Received: from ha1.rdc2.nsw.optushome.com.au ([203.164.2.50]:24501 "EHLO
	mss.rdc2.nsw.optushome.com.au") by vger.kernel.org with ESMTP
	id <S270204AbRHMOA4>; Mon, 13 Aug 2001 10:00:56 -0400
From: Manfred Bartz <mbartz@optushome.com.au>
Message-ID: <20010813140049.28744.qmail@optushome.com.au>
To: linux-kernel@vger.kernel.org
Subject: connect() does not return ETIMEDOUT
Organization: yes
Date: 14 Aug 2001 00:00:49 +1000
User-Agent: Gnus/5.0803 (Gnus v5.8.3) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When a TCP client opens multiple connections beyond the server's
backlog capacity, the call to connect() returns a value of zero 
(success) after 9 seconds. Toggling SYN-cookies makes no difference.

Is this intended behaviour?

Under Solaris I get ETIMEDOUT (Connection timed out) after a little 
less than 4 minutes.

Presumably I could set the socket to non-blocking and select() for
writability...  (I have not tested that yet.)

But if I want to keep it simple, what is the recommended solution?

-- 
Manfred Bartz

