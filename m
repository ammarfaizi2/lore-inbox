Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbTESShE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 14:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTESShE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 14:37:04 -0400
Received: from warrior.services.quay.plus.net ([212.159.14.227]:58016 "HELO
	warrior.services.quay.plus.net") by vger.kernel.org with SMTP
	id S262590AbTESShB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 14:37:01 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: "Ingo Oeser" <ingo.oeser@informatik.tu-chemnitz.de>,
       "Rusty Russell" <rusty@rustcorp.com.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: try_then_request_module
Date: Mon, 19 May 2003 19:50:02 +0100
Message-ID: <BKEGKPICNAKILKJKMHCAOEPLDAAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <20030519110832.G626@nightmaster.csn.tu-chemnitz.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo.

 > Usually this is all as simple as:
 > 
 >    int module_loaded_flag=0;
 >
 > retry_with_module_loaded:
 >    
 >    /* search code */
 >    
 >    if (!module_loaded_flag && !found) {
 >       module_loaded_flag=1;
 >       if (!request_module(bla))
 >          goto retry_with_module_loaded;
 >    }
 >    return found;
 >
 > which is very space efficient and also still readable.

Out of curiosity, what exactly is the purpose of the goto in the
above code? Since we set module_loaded_flag just prior to it, the
first if statement must fail after the goto, so we just fall down
to where we would have been without the goto.

It all looks a tad pointless to me...

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.481 / Virus Database: 277 - Release Date: 13-May-2003

