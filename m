Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267941AbUGaLVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267941AbUGaLVk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 07:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267946AbUGaLVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 07:21:38 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:58118 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S267945AbUGaLVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 07:21:09 -0400
Message-ID: <410B80BC.4060100@hp.com>
Date: Sat, 31 Jul 2004 16:51:32 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@hp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040726 Debian/1.7.1-4
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       opendlm-devel@lists.sourceforge.net,
       opengfs-users@lists.sourceforge.net,
       opengfs-devel@lists.sourceforge.net, linux-cluster@redhat.com
Subject: [ANNOUNCE] OpenSSI 1.0.0 released!!
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for the cross post. I came across this on OpenSSI website. I guess 
others may also be interested.

-aneesh

The OpenSSI project leverages both HP's NonStop Clusters for Unixware 
technology and other open source technology to provide a full, highly 
available Single System Image environment for Linux.

Feature list:
1.  Cluster Membership
   * includes libcluster  that application can use
2. Internode Communication

3. Filesystem
    * support for CFS over ext3,  Lustre Lite
    * CFS can be used for the root
    * reopen of files, devices, ipc objects when processes move is supported
    * CFS supports file record locking and shared writable mapped files 
(along with all other standard POSIX capabilities
    * HA-CFS is configurable for the root or other filesystems
4. Process Management
     * almost all pieces there, including:
           o clusterwide PIDs
           o process migration and distributed rexec(), rfork() and 
migrate() with reopen of files, sockets, pipes, devices, etc.
           o vprocs
           o clusterwide signalling, get/setpriority
           o capabilities
           o distributed process groups, session, controlling terminal
           o surrogate origin functionality
           o no single points of failure (cleanup code to deal with 
nodedowns)
           o Mosix load leveler (with the process migration model from NSC)
           o clusterwide ptrace() and strace
           o clusterwide /proc/<pid>, ps, top, etc.

5. Devices
   * there is a clusterwide device model via the devfs code
   * each node mounts its devfs on /cluster/node#/dev and bind mounts it 
to /dev so all devices are visible and accessible from all nodes, but by 
default you see only local devices
   * a process on any node can open a device on any node
   * devices are reopened when processes move
   * processes retain a context, even if they move; the context 
determines which node's devices to access by defaul
6. IPC
   * all IPC objects/mechanisms are clusterwide:
          o pipes
          o fifos
          o signalling
          o message queues
          o semaphore
          o shared memory
          o Unix-domain sockets
          o Internet-domain sockets
  * reopen of IPC objects is there for process movement
  * nodedown handling is there for all IPC objects
7. Clusterwide TCP/IP
   * HA-LVS is integrated, with extensions
   * extension is that port redirection to servers in the cluster is 
automatic and doesn't have to be managed.
8. Kernel Data Replication Service
   * it is in there (cluster/ssi/clreg)
9. Shared Storage
   * we have tested shared FCAL and use it for HA-CFS
10. DLM
   * is integrated with CLMS and is HA
11. Sysadmin
   * services architecture has been made clusterwide
12. Init, Booting and Run Levels
   * system runs with a single init which will failover/restart on 
another node if the node it is on dies
13. Application Availability
  * application monitoring/restart provided by spawndaemon/keepalive
  * services started by RC on the initnode will automatically restart on 
a failure of the initnode
14. Timesync
  * NTP for now
15. Load Leveling
  * adapted the openMosix algorithm
  * for connection load balancing, using HA-LVS
  * load leveling is on by default
  * applications must be registered to load level
16. Packaging/Install
   * Have source patch, binary RPMs and CVS source options;
   *  Debian packages also available via ap-get repository.
   * First node is incremental to a standard Linux install
   * Other nodes install via netboot, PXEboot, DHCP and simple addnode 
command;
17. Object Interfaces
   * standard interfaces for objects work as expected
   * no new interfaces for object location or movement except for 
processes (rexec(), migrate(), and /proc/pid/goto to move a process)

