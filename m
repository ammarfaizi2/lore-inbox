Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264237AbTDPGGj (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 02:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264241AbTDPGGj 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 02:06:39 -0400
Received: from calvin.stupendous.org ([213.84.70.4]:10507 "HELO
	quadpro.stupendous.org") by vger.kernel.org with SMTP
	id S264237AbTDPGGi (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 16 Apr 2003 02:06:38 -0400
Date: Wed, 16 Apr 2003 08:18:30 +0200
From: Jurjen Oskam <jurjen@quadpro.stupendous.org>
To: linux-kernel@vger.kernel.org
Subject: Booting from Qlogic qla2300 fibre channel card
Message-ID: <20030416061830.GA30423@quadpro.stupendous.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

At work, we are looking to deploy several Linux boxes on our SAN. The
machines will be IBM eServer xSeries 345 with Qlogic qla2340 Fibre Channel
cards, and no internal disks.

The storage array is an EMC Symmetrix model 8530. EMC created a document
where they explain how to make such a configuration work. When they mention
booting from a Symmetrix-provided volume, they mention the following:

"If Linux loses connectivity long enough, the disks disappear from the
system. [...] For [this reason], EMC recommends that you do not boot a
Linux host from the EMC storage array."


When making an online configuration change on the Symmetrix (such as
remapping volumes), it is possible for the attached hosts to experience
a temporary error while accessing a storage array volume. For example,
when changing the Symmetrix configuration, it is not uncommon for the
RS/6000s (also attached to the SAN) to log one or two temporary
SCSI-errors. They don't cause any problems at all, the AIX volume manager
never notices a problem.


Does the warning describe a real-world possibility? For example, what is
"long enough"?


Of course, we'll test this configuration before putting it into production
(and I'll mention our results here if they prove to be interesting), but
I'm hoping if somebody here has some useful comments. :-)

Thanks,
-- 
Jurjen Oskam

PGP Key available at http://www.stupendous.org/
