Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbVCCINi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVCCINi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 03:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVCCINh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 03:13:37 -0500
Received: from upco.es ([130.206.70.227]:47069 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S261570AbVCCINb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 03:13:31 -0500
Date: Thu, 3 Mar 2005 09:13:29 +0100
From: Romano Giannetti <romanol@upco.es>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11: suspending laptop makes system randomly unstable
Message-ID: <20050303081329.GA3004@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: romano@dea.icai.upco.es,
	linux-kernel@vger.kernel.org
References: <422618F0.3020508@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <422618F0.3020508@telefonica.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 08:50:08PM +0100, Miguelanxo Otero Salgueiro wrote:

>    - Setting randomly "last battery full charge" to a huge value 
> (example: 400 Ah when max battery capacity is 38 Ah) so I get random 
> charging/discharging timing patterns

Happens to me sometime (and misdetection of ac status too, although I
rmmod/insmod ac on suspend script). For me is not related to suspend, nor to
preempt. 

Try to put a 

  for i in 1 2 3 4 5 6 7 8; do acpi > /dev/null ; done 

in the resume script. Works for me. 

More info (config, logs, dsdt...) in
    
           http://bugme.osdl.org/show_bug.cgi?id=4124

Romano 

-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
