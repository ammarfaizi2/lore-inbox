Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUCVKJR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 05:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbUCVKJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 05:09:16 -0500
Received: from upco.es ([130.206.70.227]:51156 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S261867AbUCVKI3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 05:08:29 -0500
Date: Mon, 22 Mar 2004 11:08:24 +0100
From: Romano Giannetti <romano@dea.icai.upco.es>
To: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
       Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, Patrick Mochel <mochel@osdl.org>
Subject: AC adapter status wrong after resume (swsusp, pmdsik)
Message-ID: <20040322100824.GA27330@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: Romano Giannetti <romano@dea.icai.upco.es>,
	linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
	Nigel Cunningham <ncunningham@users.sourceforge.net>,
	Andrew Morton <akpm@osdl.org>, Patrick Mochel <mochel@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   	I think I found a problem with ACPI and disk-suspend "swsusp" option
        of 2.6.4 kernel. 
        
        In a few words: when resuming the "ac adapter status" would not
        refresh: if I suspend the laptop with the AC adapter on, then on
        resuming ACPI -v will report AC on even if I have plugged out the
        charger. Plugging the charger in and out will resume normal
        behaviour. I discovered it because cpufreqd would not lower the CPU
        clock after the resume... 
        
        HTH, 
             	Romano
                
-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
