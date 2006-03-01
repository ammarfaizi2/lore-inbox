Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWCAO7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWCAO7u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 09:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWCAO7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 09:59:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:23972 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932322AbWCAO7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 09:59:15 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mattias Nordstrom <nordstrom@realnode.com>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 12/13] Fix stv0297 for qam128 on tt c1500 (saa7146)
Date: Wed, 01 Mar 2006 09:05:40 -0300
Message-id: <20060301120540.PS28869600012@infradead.org>
In-Reply-To: <20060301120529.PS80375900000@infradead.org>
References: <20060301120529.PS80375900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Mattias Nordstrom <nordstrom@realnode.com>
Date: 1141009757 \-0300

I have a TT C1500 card (saa7146, STV0297) which had problems tuning
channels at QAM128 (like the ones in the Finnish HTV / Welho network).
A fix which seems to work perfectly so far is to change the delay for
QAM128 to the same values as for QAM256 in stv0297_set_frontend(),

Signed-off-by: Mattias Nordstrom <nordstrom@realnode.com>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/frontends/stv0297.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/media/dvb/frontends/stv0297.c b/drivers/media/dvb/frontends/stv0297.c
index 6122ba7..eb15676 100644
--- a/drivers/media/dvb/frontends/stv0297.c
+++ b/drivers/media/dvb/frontends/stv0297.c
@@ -393,10 +393,6 @@ static int stv0297_set_frontend(struct d
 		break;
 
 	case QAM_128:
-		delay = 150;
-		sweeprate = 1000;
-		break;
-
 	case QAM_256:
 		delay = 200;
 		sweeprate = 500;

