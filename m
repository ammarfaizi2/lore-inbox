Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286259AbRLJN1n>; Mon, 10 Dec 2001 08:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286261AbRLJN1e>; Mon, 10 Dec 2001 08:27:34 -0500
Received: from ns.ithnet.com ([217.64.64.10]:52231 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S286259AbRLJN1Y>;
	Mon, 10 Dec 2001 08:27:24 -0500
Date: Mon, 10 Dec 2001 14:27:07 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Burton W <bwindle@fint.org>
Cc: tulip-users@lists.sourceforge.net, jgarzik@mandrakesoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.17-pre7: Oops with Tulip
Message-Id: <20011210142707.6210b33b.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.43.0112100105140.211-100000@morpheus>
In-Reply-To: <Pine.LNX.4.43.0112100105140.211-100000@morpheus>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2001 01:08:28 -0500 (EST)
Burton W <bwindle@fint.org> wrote:

Just to test a theory: please try attached patch.

Regards,
Stephan

--- eeprom.c-orig       Mon Dec 10 14:24:35 2001
+++ eeprom.c    Mon Dec 10 14:25:41 2001
@@ -130,9 +130,9 @@
        }
 
        controller_index = 0;
-       if (ee_data[19] > 1) {          /* Multiport board. */
-               last_ee_data = ee_data;
-       }
+
+       last_ee_data = ee_data;
+
 subsequent_board:
 
        if (ee_data[27] == 0) {         /* No valid media table. */
