Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbVASPoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbVASPoB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 10:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbVASPoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 10:44:01 -0500
Received: from mail1.upco.es ([130.206.70.227]:6839 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S261754AbVASPlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 10:41:00 -0500
Date: Wed, 19 Jan 2005 16:40:57 +0100
From: Romano Giannetti <romanol@upco.es>
To: linux-kernel@vger.kernel.org
Cc: acpi-devel@lists.sourceforge.net
Subject: 2.6.11-rc1: ACPI keys events: only "arrive" after 8 of them.
Message-ID: <20050119154057.GA15099@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: Romano Giannetti <romanol@upco.es>,
	linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Linux gurus, 

     this is a minor bug that is puzzling me since my switch from 2.6.7 to
     2.6.9 (and continuing with 2.6.11-rc1).

     When I press the suspend key on my Vaio FX701, nothing happens. It
     should trigger an ACPI event that, caught by acpid, run the suspend
     script (which show a confirmation window); and so worked in 2.6.7.

          
     Now, the really strange thing: if I press it 8 times in a row, then the
     event arrives. It's as if the events are queued in a 8-depth queue. If
     now I cancel suspend, and press another special key, like the
     combination to switch video output to the external VGA, all the
     "queued" suspend-event do arrive... this happens with the two "display
     switch" key, and the "suspend" key. There is no interaction with, for
     example, lid close event which works as should. 

     I'm stymied. If anyone can help me with this, or simply tell me how to
     have more data on this, I will try to obtain all the data I can. 
     I'm using a vanilla 2.6.11-rc1, which config is available here: 

     http://www.dea.icai.upco.es/romano/linux/config-2.6.11rc1.txt

     Thank you in advance,      
                                Romano 
     

          

-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
